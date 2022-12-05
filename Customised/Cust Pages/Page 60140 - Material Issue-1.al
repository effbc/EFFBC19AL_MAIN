
page 60140 "Material Issue-1"
{
    // version MI1.0,Rev01

    PageType = Document;
    SourceTable = "Material Issues Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Service Order No."; Rec."Service Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    Caption = 'User id';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Required Date"; Rec."Required Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Released Date"; Rec."Released Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'Released BY';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Resource Name"; Rec."Resource Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Released Time"; Rec."Released Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Devide By Qty."; Rec."Devide By Qty.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(MaterialIssueLine; "Material Issue Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;


            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    RunObject = Page "Material Issue Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;

                    ShortCutKey = 'F7';
                    Visible = false;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page 5750;
                    RunPageLink = "Document Type" = CONST("Material Issues"), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Iss&ues")
                {
                    Caption = 'Iss&ues';
                    Image = Error;
                    RunObject = Page "Posted Material Issue List";
                    //RunPageLink = "Material Issue No." = FIELD("No.");
                    RunPageLink = "Material Issue No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //DIM 1.0
                        ShowDocDim;
                        //DIM 1.0
                    end;
                }
            }
        }
        area(processing)
        {
            //Caption = '<Action1900000004>';
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Release MaterialIssue Document";
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;
                }
                action("Reo&pen")
                {
                    Caption = 'Reo&pen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ReleaseMaterialIssueDoc: Codeunit "Release MaterialIssue Document";
                    begin
                        ReleaseMaterialIssueDoc.Reopen(Rec);
                    end;
                }
                separator(Action1000000119)
                {
                }
                action("Copy &Production Order")
                {
                    Caption = 'Copy &Production Order';
                    Image = Production;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD("Transfer-from Code");
                        TESTFIELD("Transfer-to Code");
                        TESTFIELD("Prod. Order No.");
                        TESTFIELD("Prod. Order Line No.");
                        CopyProductionOrder;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Copy &Sale Order")
                {
                    Caption = 'Copy &Sale Order';
                    Image = Sales;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD("Sales Order No.");
                        CopySalesOrder;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Copy &Requisition")
                {
                    Caption = 'Copy &Requisition';
                    Image = SalesTax;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CopyRequisition;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Copy Production &BOM")
                {
                    Caption = 'Copy Production &BOM';
                    Image = BOM;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD("Production BOM No.");
                        CopyProductionBOM;
                    end;
                }
                separator(Action1000000126)
                {
                }
                action("Assign Batch No's")
                {
                    Caption = 'Assign Batch No''s';
                    Image = AssemblyBOM;
                    RunObject = Codeunit "Assign Batch No's";
                    ApplicationArea = All;
                }
                separator(Action1000000022)
                {
                }
                action("Calculate Quantity")
                {
                    Caption = 'Calculate Quantity';
                    Image = UntrackedQuantity;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        MaterialIssueLine: Record "Material Issues Line";
                    begin
                        MaterialIssueLine.SETRANGE("Document No.", "No.");
                        IF MaterialIssueLine.FINDSET THEN
                            REPEAT
                                IF (MaterialIssueLine.Quantity > 1) AND ("Devide By Qty." <> 0) THEN BEGIN
                                    MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, (MaterialIssueLine.Quantity / "Devide By Qty."));
                                    MaterialIssueLine.MODIFY;
                                END;
                            UNTIL MaterialIssueLine.NEXT = 0;
                        "Devide By Qty." := 0;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        charline := 10;
                        Mail_Body := '';
                        Subject := '';
                        Mail_From := 'erp@efftronics.com';
                        //Mail_To:='ramadevi@efftronics.net,nayomi@efftronics.net,Shilpa@efftronics.net,';
                        // Mail_To := 'krishnad@efftronics.com,santhoshk@efftronics.com';
                        Recipient.Add('krishnad@efftronics.com');
                        Recipient.Add('santhoshk@efftronics.com');
                        // Mail_To:='santhoshk@efftronics.com';
                        Subject := ' ISSUED MATERIAL FROM ' + "Transfer-from Code" + ' TO ' + "Transfer-to Code";
                        IF MaterialIssuesHeader."Transfer-to Code" = 'DAMAGE' THEN
                            Mail_Body += 'Damage By   :' + FORMAT("Resource Name") + '(' + FORMAT("User ID") + ')'
                        ELSE
                            IF (MaterialIssuesHeader."Transfer-to Code" = 'STR') OR (MaterialIssuesHeader."Transfer-to Code" = 'R&D STR') OR
                             (MaterialIssuesHeader."Transfer-to Code" = 'CS STR') THEN
                                Mail_Body += 'Returned By   :' + FORMAT("Resource Name") + '(' + FORMAT("User ID") + ')'
                            ELSE
                                Mail_Body += 'Issued To :' + FORMAT("Resource Name") + '(' + FORMAT("User ID") + ')';

                        Mail_Body += FORMAT(charline);
                        j := 0;
                        Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", "No.");
                        Mat_Issue_sLine.SETFILTER(Mat_Issue_sLine."Qty. to Receive", '>%1', 0);
                        IF Mat_Issue_sLine.FINDSET THEN
                            REPEAT
                                IF ((Mat_Issue_sLine."Item No." = 'METOLGN00017') OR (Mat_Issue_sLine."Item No." = 'METOLGN00035')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00036') OR (Mat_Issue_sLine."Item No." = 'METOLGN00075')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00038') OR (Mat_Issue_sLine."Item No." = 'METOLGN00076')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00084') OR (Mat_Issue_sLine."Item No." = 'METOLGN00111')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00141') OR (Mat_Issue_sLine."Item No." = 'METOLGN00159')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00216') OR (Mat_Issue_sLine."Item No." = 'METOLGN00223')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00233') OR (Mat_Issue_sLine."Item No." = 'METOLGN00234')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00034') OR (Mat_Issue_sLine."Item No." = 'METOLGN00086')) THEN BEGIN
                                    Mail_Body += 'Item           :' + Mat_Issue_sLine.Description + '(' + Mat_Issue_sLine."Item No." + ')';
                                    Mail_Body += FORMAT(charline);
                                    Mail_Body += 'Serial No.     :';
                                    Mail_Body += FORMAT(charline);
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order No.", "No.");
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order Line No.", Mat_Issue_sLine."Line No.");
                                    IF "Tracking Specification".FINDSET THEN
                                        REPEAT
                                            IF "Tracking Specification"."Serial No." <> '' THEN
                                                Mail_Body += "Tracking Specification"."Serial No." + ','
                                        UNTIL "Tracking Specification".NEXT = 0;

                                    Mail_Body += FORMAT(charline);
                                    j := 1;
                                END;
                            UNTIL Mat_Issue_sLine.NEXT = 0;
                        IF j = 1 THEN
                            // Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Mail_Body, '');
                            EmailMessage.Create(Recipient, Subject, Mail_Body, false);
                        CODEUNIT.RUN(60011, Rec);
                    end;
                }
            }
            action("P&rint New")
            {
                Caption = 'P&rint New';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Material Requisition Print";
                ApplicationArea = All;
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    DocPrint: Codeunit 229;
                begin
                    //DocPrint.PrintTransferHeader(Rec);
                    MaterialIssuesHeader.SETRANGE("No.", "No.");
                    REPORT.RUN(70001, TRUE, FALSE, MaterialIssuesHeader);
                end;
            }
            action(Comment)
            {
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 5750;
                RunPageLink = "Document Type" = CONST("Material Issues"), "No." = FIELD("No.");
                ToolTip = 'Comment';
                ApplicationArea = All;
            }
        }
    }

    var
        MaterialIssuesHeader: Record "Material Issues Header";
        Mat_Issue_sLine: Record "Material Issues Line";
        SMTPSETUP: Record "SMTP SETUP";
        "Mail-Id": Record User;
        Recipient: List of [Text];
        EmailMessage: Codeunit "Email Message";
        Mail_From: Text[150];
        Mail_To: Text[1000];
        Subject: Text[1000];
        Mail_Body: Text[1000];
        bodies: Integer;
        //>> ORACLE UPG
        /*   objEmailConf: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000002-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Configuration";
          objEmail: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000001-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Message";
          flds: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000564-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Fields";
          fld: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000569-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Field"; */
        //<< ORACLE UPG
        charline: Char;
        charline2: Char;
        j: Integer;
        "Tracking Specification": Record "Mat.Issue Track. Specification";
        Mail: Codeunit Mail;
        Email: Codeunit Email;
}

